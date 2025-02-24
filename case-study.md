# Case Strudy

## Подготовка

- [x] запустить проект
- [x] настроить NewRelic (docker compose -f docker-compose.yaml up -d)
- [x] настроить rack-mini-profiler
- [x] для нагрузки подготовил siege
- [x] local_production
- [] использовать альтернативу NewRelic

## Оптимизация

Сразу для того чтобы сравнить решил сравнивать вывод в NewRelic и RMP(по подробности данным всё же RMP более удобный, меньше повторяющейся информации и больше подробностей).

Получил что при первой загруку страница запускалась где-то 3252.06 ms, при повторной ускорилось до 1300 - 1600.1 ms, из-за разных кэшей браузера и уже настроенных кэшей приложения.

через RMP видно что проблема рендерингом main_stories_feed, а точнее _single_story
<details>

```
/ (1362.6 ms)

event	duration (ms)	from start (ms)	query time (ms)
GET http://localhost:3000/	36.3	+0.0	
  Executing: stories#index	103.1	+17.0	2 sql	5.1
   Rendering: layouts/application.html.erb	169.8	+120.7	
    Rendering: articles/index.html.erb	124.4	+147.2	2 sql	23.9
     Rendering: articles/_sidebar.html.erb	27.7	+162.3	
     Rendering: stories/_main_stories_feed.html.er...	368.9	+257.5	
      Rendering: articles/_single_story.html.erb	21.6	+275.3	
      Rendering: articles/_single_story.html.erb	18.3	+312.3	
      Rendering: articles/_single_story.html.erb	16.1	+344.4	
      Rendering: articles/_single_story.html.erb	16.8	+373.9	
      Rendering: articles/_single_story.html.erb	18.8	+419.8	
      Rendering: articles/_single_story.html.erb	59.2	+452.3	
      Rendering: articles/_single_story.html.erb	17.6	+532.9	
      Rendering: articles/_single_story.html.erb	19.3	+566.2	
      Rendering: articles/_single_story.html.erb	16.7	+599.8	
      Rendering: articles/_single_story.html.erb	15.7	+630.7	
      Rendering: articles/_single_story.html.erb	23.4	+660.1	
      Rendering: articles/_single_story.html.erb	21.3	+699.0	
      Rendering: articles/_single_story.html.erb	17.6	+742.9	
      Rendering: articles/_single_story.html.erb	19.5	+774.9	
      Rendering: articles/_single_story.html.erb	18.3	+810.2	
      Rendering: articles/_single_story.html.erb	17.9	+844.7	
      Rendering: articles/_single_story.html.erb	17.9	+876.7	
      Rendering: articles/_single_story.html.erb	17.4	+908.2	
      Rendering: articles/_single_story.html.erb	17.7	+939.9	
      Rendering: articles/_single_story.html.erb	16.1	+972.5	
      Rendering: articles/_single_story.html.erb	16.0	+1002.6	
      Rendering: articles/_single_story.html.erb	16.4	+1031.2	
      Rendering: articles/_single_story.html.erb	18.0	+1061.9	
      Rendering: articles/_single_story.html.erb	18.1	+1096.4	
     Rendering: articles/_sidebar_additional.html....	28.2	+1128.8	
    Rendering: layouts/_styles.html.erb	14.6	+1200.4	
show time with childrensnapshots2.1 % in sql
```
</details>

при нагрузке через ab, сразу отваливается по таймауту, результаты получит не получилось.
<details>

```
romaS:~/ $ ab -n 100 -c 5 127.0.0.1:3000/
This is ApacheBench, Version 2.3 <$Revision: 1913912 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient)...apr_pollset_poll: The timeout specified has expired (70007)
```
</details>


Посмотревчто можно сделать, и учитывая совет из задачи мы понимаем что нам позволительно закэшировать  `<%= render "articles/single_story", story: story %>`.
Проверим эту гипотезу, добавляем кэширование


Как результат первая загрузка не поменялас в среднем как и было 3252.06 ms, но при этом любая повторная загрузка уже выполняется в среднем за 588 ms. Что довольно силь что в 2.2 быстрее чем без использования кэшей. Так же успешно удалось назузить через `ab -n 100 -c 5 127.0.0.1:3000/`

<details>

```

 (588.4 ms)
event	duration (ms)	from start (ms)	query time (ms)
GET http://localhost:3000/	28.9	+0.0	
  Executing: stories#index	94.8	+10.0	2 sql	3.7
   Rendering: layouts/application.html.erb	197.5	+105.2	
    Rendering: articles/index.html.erb	114.0	+139.3	2 sql	16.0
     Rendering: articles/_sidebar.html.erb	31.6	+156.4	
     Rendering: stories/_main_stories_feed.html.er...	77.7	+242.8	
     Rendering: articles/_sidebar_additional.html....	27.8	+335.2	
    Rendering: layouts/_styles.html.erb	14.6	+407.4	
show time with childrensnapshots3.3 % in sql

```

```

romaS:~/ $ ab -n 100 -c 5 127.0.0.1:3000/
                                                                                                                               
This is ApacheBench, Version 2.3 <$Revision: 1913912 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient).....done


Server Software:
Server Hostname:        127.0.0.1
Server Port:            3000

Document Path:          /
Document Length:        158268 bytes

Concurrency Level:      5
Time taken for tests:   209.115 seconds
Complete requests:      100
Failed requests:        99
   (Connect: 0, Receive: 0, Length: 99, Exceptions: 0)
Total transferred:      15946689 bytes
HTML transferred:       15846641 bytes
Requests per second:    0.48 [#/sec] (mean)
Time per request:       10455.725 [ms] (mean)
Time per request:       2091.145 [ms] (mean, across all concurrent requests)
Transfer rate:          74.47 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:  1701 10294 7288.4   8318   43677
Waiting:     1697 10285 7288.8   8297   43675
Total:       1701 10294 7288.5   8318   43677

Percentage of the requests served within a certain time (ms)
  50%   8318
  66%   8570
  75%   9021
  80%   9435
  90%  15895
  95%  31402
  98%  43428
  99%  43677
 100%  43677 (longest request)
```

</details>

## Заключение
Как вердикт проверка теории о использовании кэшей для `articles/single_story` принесла свои результаты и ускорила повторные загрузки страницы в 2 раза.




# Доп подкючение local_production

При создании local_production окружении и использовании его, видны следующие улучшения максимально приближённые к продовому окруэениею.
 - время загрузки посторной страницы занимает теперь не 588.4 ms, а 129 ms
 - при нагрузки через `ab -n 100 -c 5 127.0.0.1:3000/`, уменьшилось в 10 раз среднее время по всем показателям
 было
 ```
  Time per request:       10455.725 [ms] (mean)
  Time per request:       2091.145 [ms] (mean, across all concurrent requests)
 ```
 стало
 ```
  Time per request:       1043.882 [ms] (mean)
  Time per request:       208.776 [ms] (mean, across all concurrent requests)
 ```

<details>
```
/ (129.9 ms)
event	duration (ms)	from start (ms)	query time (ms)
GET http://localhost:3000/	46.0	+0.0	
  Executing: stories#index	-29.6	+15.0	2 sql	4.0
   Rendering: articles/index.html.erb	46.0	+39.4	2 sql	22.6
    Rendering: stories/_main_stories_feed.html.er...	7.1	+85.7	
   Rendering: layouts/application.html.erb	58.8	+40.0	
show time with childrensnapshots20.5 % in sql
client event	duration (ms)	from start (ms)
Response	2.0	+160.0
sharemore show trivial
```

```
romaS:.dev_to/ (master✗) $ ab -n 100 -c 5 127.0.0.1:3000/   
This is ApacheBench, Version 2.3 <$Revision: 1913912 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient).....done


Server Software:
Server Hostname:        127.0.0.1
Server Port:            3000

Document Path:          /
Document Length:        129969 bytes

Concurrency Level:      5
Time taken for tests:   20.878 seconds
Complete requests:      100
Failed requests:        99
   (Connect: 0, Receive: 0, Length: 99, Exceptions: 0)
Total transferred:      13115169 bytes
HTML transferred:       13014935 bytes
Requests per second:    4.79 [#/sec] (mean)
Time per request:       1043.882 [ms] (mean)
Time per request:       208.776 [ms] (mean, across all concurrent requests)
Transfer rate:          613.47 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   394  968 548.3    787    2999
Waiting:      392  958 549.7    779    2986
Total:        394  968 548.3    787    2999

Percentage of the requests served within a certain time (ms)
  50%    787
  66%    911
  75%   1017
  80%   1223
  90%   1844
  95%   2187
  98%   2959
  99%   2999
 100%   2999 (longest request)
```
</details>