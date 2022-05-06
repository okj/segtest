# segtest
 
Simple bash script for automating the typical scanning process on a segmentation test

1. [nmap](https://nmap.org/book/man.html) scanning

**TCP Scan on all ports**
```console
nmap -sC -Pn -T4 -vv -n -p-
```

**UDP Scan on top 1,000 ports**
```console
nmap -sU -sC -Pn -T4 -vv -n --top-ports 1000
```

2. [WitnessMe](https://github.com/byt3bl33d3r/WitnessMe) on nmap results

3. Results in CSV form
```
Host,Port,Status,Protocol,Service
```

---

## Example Usage
```console
./segtest 10.0.0.1-55
./segtest 10.0.0.0/24
./segtest 10.0.0.8,10.0.0.134
```
The one and only argument just gets passed to nmap as the [target](https://nmap.org/book/man-target-specification.html) so do whatever.

## TODO
*In no particular order...*

* Arg for an optional project name
* Allow input as file/Multiple inputs
* Divide targets to run simultaneous nmap scans (2-3)
* A more elegant (bash) way of creating the `results.csv` file
* Arguments to control target TCP/UDP ports (and passthrough/overwrite anything else as an nmap arg)
* Ability to pause/resume scans
* (Option to) sort and group results by port/service
* Attempt netcat client on open ports + report results