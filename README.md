# ovld_microservices
ovld microservices repository

### docker-2
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

### docker-3

 - Получили разбитое на микросервисы приложение reddit;
 - Собрали каждый микросервис в докер контейнер;
 - Оптимизировал контейнеры с 700 до ~100 мб каждый;
 - Запушил на хаб наше приложение;
 - Перед работой необходимо создать докер хост на gcp:
 ```
 docker-machine create --driver google \\n--google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-\nos-cloud/global/images/family/ubuntu-1604-lts \\n--google-machine-type n1-standard-1 \\n--google-zone us-central1-a \\ndocker-n1
eval $(docker-machine env docker-machine)

```
 - Перед сборкой необходимо зайти в директорию^
```
cd src
```
 - Собрать контейнерры можно вот так:

```
docker build -t ovld/post:1.0 ./post-py
docker build -t ovld/comment:1.0 ./comment
docker build -t ovld/ui:1.0 ./ui
```

 - Необходимо создать одну сеть для сервиса:
```
docker network create reddit
```
 - Создать том для базки:
```
docker volume create reddit_db
```

 - Запустить контейнеры:
```
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:4.2.6
docker run -d --network=reddit --network-alias=post ovld/post:1.0
docker run -d --network=reddit --network-alias=comment ovld/comment:1.0
docker run -d --network=reddit -p 9292:9292 ovld/ui:1.0
```
