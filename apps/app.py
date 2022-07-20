import falcon
import json

from urllib.request import urlopen
from wsgiref.simple_server import make_server
from falcon_multipart.middleware import MultipartMiddleware

app = falcon.API()
app.req_options.auto_parse_form_urlencoded = True
app.resp_options.secure_cookies_by_default = False


class GetRegion:
    def on_get(self, req: falcon.request, res: falcon.response):
        ip_addr = req.get_param('ip_addr')
        data = dict()
        if ip_addr is not None and len(ip_addr) > 8:
            try:
                url = f'http://ipinfo.io/{ip_addr}/json'
                resp = urlopen(url)
                data = json.load(resp)
            except:
                pass

        res.body = json.dumps(data)
        return True


app.add_route('/get_region', GetRegion())

if __name__ == '__main__':
    with make_server('', 8890, app) as httpd:
        httpd.serve_forever()
