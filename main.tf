resource "yandex_compute_instance" "http_server" {
  name = "http-server"

  resources {
    core_fraction = 20
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd874d4jo8jbroqs6d7i"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.http-server_subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
 
  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    private_key = file(var.private_key_path)
  }
 
  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_vpc_network" "http-server_network" {
  name = "http-server-network"
}

resource "yandex_vpc_subnet" "http-server_subnet" {
  name           = "http-server-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.http-server_network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
