import json
import os
import socket
from datetime import datetime, timezone
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path

HOST = "0.0.0.0"
PORT = 8000
STARTED_AT = datetime.now(timezone.utc).replace(microsecond=0).isoformat()
REQUEST_COUNT = 0
STATIC_DIR = Path(__file__).with_name("static")


def env_flag_is_true(name, default="false"):
    value = os.getenv(name, default)
    return value.strip().lower() in {"1", "true", "yes", "on"}


def increment_request_count():
    global REQUEST_COUNT
    REQUEST_COUNT += 1
    return REQUEST_COUNT


def get_runtime_metadata():
    return {
        "environment": os.getenv("APP_ENV", "local"),
        "app_version": os.getenv("APP_VERSION", "dev"),
        "commit_sha": os.getenv("COMMIT_SHA", "unknown"),
        "deployed_at": os.getenv("DEPLOYED_AT", "unknown"),
        "image_tag": os.getenv("IMAGE_TAG", "unknown"),
        "deployment_mode": os.getenv("DEPLOY_MODE", "local-direct"),
        "force_unhealthy": env_flag_is_true("FORCE_UNHEALTHY"),
        "started_at": STARTED_AT,
        "request_count": REQUEST_COUNT,
        "hostname": socket.gethostname(),
    }


def get_safe_config():
    metadata = get_runtime_metadata()
    return {
        "bind_host": HOST,
        "port": PORT,
        "environment": metadata["environment"],
        "deployment_mode": metadata["deployment_mode"],
        "app_version": metadata["app_version"],
        "image_tag": metadata["image_tag"],
        "commit_sha": metadata["commit_sha"],
        "started_at": metadata["started_at"],
        "force_unhealthy": metadata["force_unhealthy"],
    }


def get_health_payload():
    if env_flag_is_true("FORCE_UNHEALTHY"):
        return 503, {"status": "unhealthy", "reason": "FORCE_UNHEALTHY is enabled"}
    return 200, {"status": "ok"}


def get_ready_payload():
    health_status, _ = get_health_payload()
    if health_status != 200:
        return 503, {"status": "not-ready", "reason": "FORCE_UNHEALTHY is enabled"}
    return 200, {"status": "ready", "checks": {"app": "loaded", "config": "available"}}


def route_request(path):
    if path == "/health":
        return get_health_payload()

    if path == "/ready":
        return get_ready_payload()

    if path == "/version":
        metadata = get_runtime_metadata()
        return 200, {
            "app_version": metadata["app_version"],
            "commit_sha": metadata["commit_sha"],
            "image_tag": metadata["image_tag"],
        }

    if path == "/status":
        payload = {"status": "ok"}
        payload.update(get_runtime_metadata())
        return 200, payload

    if path == "/config":
        return 200, get_safe_config()

    return 404, {"error": "not found"}


def render_home_page():
    metadata = get_runtime_metadata()
    environment = metadata["environment"]
    return f"""<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tiny Health App</title>
    <link rel="stylesheet" href="/static/site.css">
  </head>
  <body class="env-{environment}">
    <main class="page-shell">
      <section class="hero-card">
        <p class="eyebrow">Tiny Health App</p>
        <h1>Deployment check: looking cheerful.</h1>
        <p class="tagline">
          If you can see this page from your browser, your app is really running somewhere useful.
        </p>
        <div class="banner">
          <span class="banner-label">Environment</span>
          <strong>{environment}</strong>
        </div>
      </section>

      <section class="grid">
        <article class="card">
          <h2>Quick status</h2>
          <p id="health-text">Loading health...</p>
          <p id="ready-text">Loading readiness...</p>
          <button id="ping-button" type="button">Ping the app</button>
          <p id="ping-result" class="hint">Press the button to fetch live endpoint data.</p>
        </article>

        <article class="card">
          <h2>Runtime details</h2>
          <dl class="details">
            <div><dt>Version</dt><dd id="version-value">{metadata["app_version"]}</dd></div>
            <div><dt>Commit</dt><dd id="commit-value">{metadata["commit_sha"]}</dd></div>
            <div><dt>Host</dt><dd id="hostname-value">{metadata["hostname"]}</dd></div>
            <div><dt>Started</dt><dd id="started-at-value">{metadata["started_at"]}</dd></div>
            <div><dt>Requests</dt><dd id="request-count-value">{metadata["request_count"]}</dd></div>
          </dl>
        </article>

        <article class="card">
          <h2>Why this matters</h2>
          <ul>
            <li>The homepage proves something is running on the target.</li>
            <li>The metadata helps explain what build reached the VM.</li>
            <li>The counter resets on restart, so it is a tiny restart clue.</li>
          </ul>
          <p class="hint">This app is small on purpose. The pipeline is still the main lesson.</p>
        </article>
      </section>
    </main>

    <script>
      async function refreshStatus() {{
        const [healthResponse, readyResponse, statusResponse] = await Promise.all([
          fetch("/health"),
          fetch("/ready"),
          fetch("/status"),
        ]);

        const healthBody = await healthResponse.json();
        const readyBody = await readyResponse.json();
        const statusBody = await statusResponse.json();

        document.getElementById("health-text").textContent =
          `Health: ${{healthBody.status}}`;
        document.getElementById("ready-text").textContent =
          `Ready: ${{readyBody.status}}`;
        document.getElementById("version-value").textContent = statusBody.app_version;
        document.getElementById("commit-value").textContent = statusBody.commit_sha;
        document.getElementById("hostname-value").textContent = statusBody.hostname;
        document.getElementById("started-at-value").textContent = statusBody.started_at;
        document.getElementById("request-count-value").textContent = statusBody.request_count;
      }}

      async function pingApp() {{
        const response = await fetch("/status");
        const payload = await response.json();
        document.getElementById("ping-result").textContent =
          `Ping ok: ${{payload.environment}} on ${{payload.hostname}}`;
        document.getElementById("request-count-value").textContent = payload.request_count;
      }}

      document.getElementById("ping-button").addEventListener("click", pingApp);
      refreshStatus().catch((error) => {{
        document.getElementById("ping-result").textContent =
          `Could not refresh status: ${{error.message}}`;
      }});
    </script>
  </body>
</html>
"""


class AppHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        increment_request_count()

        if self.path == "/":
            body = render_home_page().encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            return

        if self.path == "/static/site.css":
            body = STATIC_DIR.joinpath("site.css").read_bytes()
            self.send_response(200)
            self.send_header("Content-Type", "text/css; charset=utf-8")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            return

        status_code, payload = route_request(self.path)
        body = json.dumps(payload).encode("utf-8")

        self.send_response(status_code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, format, *args):
        return


def run():
    server = HTTPServer((HOST, PORT), AppHandler)
    print(f"Server running on http://{HOST}:{PORT}")
    server.serve_forever()


if __name__ == "__main__":
    run()
