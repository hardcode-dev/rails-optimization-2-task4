## Оптимизация бэкенда

> Рассмотрите гипотезу о том, что можно закешировать `<%= render "articles/single_story", story: story %>` в `_main_stories_feed.html.erb` и это даст заметный эффект. (В этот паршл входят счётчики лайков и комментариев, они не заморозятся?)

Если использовать `story.cache_key`, то по идее не заморозятся, т.к. счётчик берётся из поля модели (`cache_counter`).

Без кэша:

```
Concurrency Level:      5
Time taken for tests:   19.728 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      15922500 bytes
HTML transferred:       15875800 bytes
Requests per second:    5.07 [#/sec] (mean)
Time per request:       986.417 [ms] (mean)
Time per request:       197.283 [ms] (mean, across all concurrent requests)
Transfer rate:          788.17 [Kbytes/sec] received
```

С кэшем:

```
Concurrency Level:      5
Time taken for tests:   11.927 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      15788300 bytes
HTML transferred:       15741600 bytes
Requests per second:    8.38 [#/sec] (mean)
Time per request:       596.328 [ms] (mean)
Time per request:       119.266 [ms] (mean, across all concurrent requests)
Transfer rate:          1292.77 [Kbytes/sec] received
```

Как будто бы помогло. Проверяла с отключеным rack-mini-profiler (и т.д. штуками)