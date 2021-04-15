Разворачиваем Jenkins CI и две дополнительные машины, которые эмулируют production и stating окружения в [Yandex Cloud][].

## Использование 

Для начала необходимо отредактировать конфигурационный файл terraform/[main.tf][] указав ваши настройки [провайдера][]


### Создание инфраструктуры

Следующая команда развернет три виртуальные машины и создаст файл inventory для Ansible:
```sh
make infrastructure
```


### Настраиваем окружение

После того как виртуальные машины готовы, устанавливаем Jenkins и Docker выполнив команду:
```sh
make environment
```
Дополнительно производится генерация и добавление ключей к целевым машинам.
Jenkins CI может подключаться по ssh на production и staging сервера. 


### Настраиваем pipeline

Создав в Jenkins Multibranch Pipeline и указав в качестве источника следующий [репозиторий][] мы добавим в Jenkins 5 джоб:
1. Запуск контейнера с WordPress на staging-машине.
1. Запуск контейнера с WordPress на production-машине.
1. Джоба с использованием планировщика, где раз в 5 минут скрипт проверяет, пингуются ли production и staging серверы.
1. Джоба, которая выполняет получение данных uptime с production и staging.
1. Джоба, которая выполняет перезагрузку production и staging с возможность выбора одной из них или всех сразу (build with params). 


### Удаление

Удалить кластер и виртуальные машины:
```sh
make destroy
```


[Yandex Cloud]: https://cloud.yandex.ru/
[main.tf]: https://github.com/mihailag/sf__jenkins_environment/terraform/main.tf
[провайдера]: https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart#configure-provider
[репозиторий]: https://github.com/mihailag/sf__jenkins_environment_jobs