resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_container" {
  name  = "my-nginx-container"
  image = docker_image.nginx_image.name

  ports {
    internal = 80
    external = 8080
  }

  volumes {
    host_path      = "/path/to/local/nginx/conf"
    container_path = "/etc/nginx/conf.d"
  }

  env = [
    "NGINX_PORT=80"
  ]

  restart = "always"
}
