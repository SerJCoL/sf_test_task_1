terraform {
  required_version = ">= 1.8" # будут разрешены для использования все версии клиентов Terraform между
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.128.0"
    }
  }
}

resource "yandex_compute_instance" "http_server" {
  name = "http-server"

  resources {
    core_fraction = 20
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
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
