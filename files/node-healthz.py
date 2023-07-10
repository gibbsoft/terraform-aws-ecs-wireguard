#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from http.server import HTTPServer, BaseHTTPRequestHandler
from optparse import OptionParser
import subprocess


class HealthCheck(BaseHTTPRequestHandler):

    def do_GET(self):
        if check(self.server.container):
            self.send_response(200)
            self.send_header("Content-Type", "text/plain")
            self.end_headers()
            self.wfile.write(b"healthy\n")
        else:
            self.send_error(404)

    def do_HEAD(self):
        self.do_GET()


def check(container):
    process = subprocess.Popen(
        ['docker', 'inspect', '--format="{{json .State.Health}}"', container], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    return stdout.decode('utf-8').find("healthy") > 0


def test(container):
    if check(container):
        print("%s up" % container)
    else:
        print("%s down" % container)


def main(port, container):
    server = HTTPServer(('', port), HealthCheck)
    server.container = container
    server.serve_forever()


def opts():
    parser = OptionParser(
        description="ECS agent container is healthy")
    parser.add_option("-c", "--container", dest="container", default="ecs-agent",
                      help="container name to check (default ecs-agent)")
    parser.add_option("-p", "--port", dest="port", default=32767, type="int",
                      help="port on which to listen (default 32767)")
    parser.add_option("-t", "--test", action="store_true", dest="test", default=False,
                      help="show status and exit")
    return parser.parse_args()[0]


if __name__ == "__main__":
    options = opts()
    if options.test:
        test(options.container)
    else:
        main(options.port, options.container)
