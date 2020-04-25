# ovld_microservices
ovld microservices repository

### docker-4
 - Создали докер хосты в gcp с помощью docker-machine;
 - Описали очень плохой образ нашего приложения с бд в одном контейнере;
 - Зпушили этот позор на докер хаб;
 - Описали с помощью ansible установку docker на хост;
 - Создали с помощью packer и ansible базовый образ для работы с докером;
 - Описали с помощью terraform создание инстанцев в gcp с образом выше;
 - Терраформ учитывает количество нод докер хостов;
 - Описали плейбук для запуска нашего приложения;

 ```
cd docker-monolith/infra
# Собираем образ:
packer build -var-file packer/variables.json packer/docker.json
# Разворачиваем инфру:
cd terraform
terraform init
terraform apply
# Запускаем контейнер с образа ovld/otus-reddit:1.0
cd ../ansible
pip install -r requirements.txt
ansible all -m ping
ansible-playbook playbooks/app.yml
```
