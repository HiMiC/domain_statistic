# Статистика доменов

Взято из форка https://github.com/akmua/domain_statistic

Скрипт для сбора статистики для зон ru/su/rf. Собираются все записи c DNS, 
Автономная система, переод делегирования

Статья с описанием https://habrahabr.ru/post/301894/

Для работы необходимы модули:
- MySQLdb
- dnspython
- SubnetTree
- psutil >= 2.2

Самый простой вариант запуска через Docker.

# Пример запуска:

устанавливаем Docker и git

* sudo apt-get update 
* sudo apt-get install docker.io git

Скачиваем репозиторий

* cd /home
* git clone https://github.com/himic/domain_statistic.git

Собираем образы

* cd domain_statistic/docker
* docker-compose build

запускаем контейнеры

* docker-compose up -d


* docker-compose exec mysql bash
* docker-compose exec recurcer bash
* docker-compose exec runner bash


##### crontab task for runner
Чтобы понимать почему изначально база пустая и знать когда она наполнится
~~~~
# каждые 15 дней в 1 час 10 мин
10 1 */15 * * /usr/bin/python /home/domain_statistic/update_as_info.py >> /home/domain_statistic/download/update_as_info.log
# каждый день в 0 часов 5 минут
5 0 * * * /usr/bin/python /home/domain_statistic/update_domain.py -n `cat /etc/resolv.conf | awk '{print $2}'` -u >> /home/domain_statistic/download/update_domain.log
# каждый день в 12 часов дня и 30 минут
30 12 * * * /usr/bin/python /home/domain_statistic/update_regru.py >> /home/domain_statistic/download/update_regru.log
# Каждые 30 дней в 10 часов 1 минуту
1 10 */30 * * /usr/bin/python /home/domain_statistic/normalization.py
~~~~