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

## После того как закешировали паршл

```bash
Server Software:        
Server Hostname:        localhost
Server Port:            3000

Document Path:          /
Document Length:        160220 bytes

Concurrency Level:      5
Time taken for tests:   31.519 seconds
Complete requests:      100
Failed requests:        67
   (Connect: 0, Receive: 0, Length: 67, Exceptions: 0)
Total transferred:      16123231 bytes
HTML transferred:       16022065 bytes
Requests per second:    3.17 [#/sec] (mean)
Time per request:       1575.967 [ms] (mean)
Time per request:       315.193 [ms] (mean, across all concurrent requests)
Transfer rate:          499.55 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.1      0       1
Processing:   286 1549 188.3   1558    1919
Waiting:      286 1544 186.5   1551    1909
Total:        286 1549 188.3   1558    1919

Percentage of the requests served within a certain time (ms)
  50%   1558
  66%   1602
  75%   1636
  80%   1651
  90%   1753
  95%   1807
  98%   1851
  99%   1919
 100%   1919 (longest request)
 ```

 ## на local_production окружении с кешированием и прекомпиляци ассетов

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
