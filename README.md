1. Реализовать контейнер Docker, который будет слушать порт, при обращении к которому по протоколу HTTP с указанием любого URL (с соблюдением всех спецификаций HTTP) в качестве payload ответа будет возвращаться текст «Hello!» с заголовком «Content-Type: text/plain».
2. Реализовать код на Terraform (совместимый с Terraform 0.12), позволяющий запустить реализованный на предыдущем шаге контейнер с помощью наиболее оптимального (с вашей точки зрения) сервиса GCP по следующим критериям:
3. Реализовать Helm-чарт (совместимый с Helm 3), позволяющий запустить уже реализованный на первом шаге контейнер в Kubernetes с доступом извне (наиболее предпочтительным способом с вашей точки зрения).
