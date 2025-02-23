## До оптимизации

```bash
Server Software:        
Server Hostname:        localhost
Server Port:            3000

Document Path:          /
Document Length:        159427 bytes

Concurrency Level:      5
Time taken for tests:   33.310 seconds
Complete requests:      100
Failed requests:        99
   (Connect: 0, Receive: 0, Length: 99, Exceptions: 0)
Total transferred:      16069032 bytes
HTML transferred:       15970086 bytes
Requests per second:    3.00 [#/sec] (mean)
Time per request:       1665.483 [ms] (mean)
Time per request:       333.097 [ms] (mean, across all concurrent requests)
Transfer rate:          471.11 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   817 1623 220.8   1622    2054
Waiting:      817 1618 220.0   1618    2045
Total:        817 1623 220.8   1622    2054

Percentage of the requests served within a certain time (ms)
  50%   1622
  66%   1722
  75%   1756
  80%   1804
  90%   1881
  95%   1956
  98%   2017
  99%   2054
 100%   2054 (longest request)
```

## После того как закешировали паршл среднее время ответа уменьшилось в 2,5 раза

```bash
Server Software:
Server Hostname:        localhost
Server Port:            3000
Document Path:          /
Document Length:        143451 bytes
Concurrency Level:      5
Time taken for tests:   2.669 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      14387400 bytes
HTML transferred:       14345100 bytes
Requests per second:    37.46 [#/sec] (mean)
Time per request:       832.472 [ms] (mean)
Time per request:       145.694 [ms] (mean, across all concurrent requests)
Transfer rate:          5263.34 [Kbytes/sec] received
Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.2      0       1
Processing:    68  124  26.5    115     206
Waiting:       66  122  26.1    112     205
Total:         68  125  26.5    116     206
Percentage of the requests served within a certain time (ms)
  50%    116
  66%    135
  75%    143
  80%    146
  90%    157
  95%    175
  98%    198
  99%    206
 100%    206 (longest request)
 ```

 ## на local_production окружении с кешированием и прекомпиляци ассетов срднее время ответа уменьшилось почти в 5 раз

```bash
Server Software:        
Server Hostname:        localhost
Server Port:            3000

Document Path:          /
Document Length:        135209 bytes

Concurrency Level:      5
Time taken for tests:   8.778 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      13563200 bytes
HTML transferred:       13520900 bytes
Requests per second:    11.39 [#/sec] (mean)
Time per request:       438.925 [ms] (mean)
Time per request:       87.785 [ms] (mean, across all concurrent requests)
Transfer rate:          1508.84 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:   123  429 101.5    427     682
Waiting:      122  411 101.9    398     663
Total:        123  429 101.5    427     682

Percentage of the requests served within a certain time (ms)
  50%    427
  66%    469
  75%    499
  80%    518
  90%    556
  95%    624
  98%    665
  99%    682
 100%    682 (longest request)
```
