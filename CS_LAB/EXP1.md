### Tools Required:

```
netcat whatweb nslookup nmap sherlock netdiscover dirb nikto angryipscanner whois
```

-- -

### Tools that require manual installation:

- Install Angry IP Scanner for your operating system.
    
    [Angry IP Scanner - Download for Windows, Mac or Linux](https://angryip.org/download/)
    
- Download sherlock in kali linux
    
    ```sql
    sudo apt install -y sherlock
    ```
    

-- -

### Lab Setup

> Identify your Kali Machine’s IP Address, we use this IP to probe for alive hosts on the same subnet
> 
> 
> ```sql
> ip a show eth0
> ```
> 

![Screenshot](https://prod-files-secure.s3.us-west-2.amazonaws.com/9241cffa-aa68-4892-bc14-163ea6c8344c/794ae605-c16c-4213-be69-6178ded87cc0/Untitled.png)

Run the above command to identify your ipv4 address, mine is `10.10.10.4`, so I will be using this subnet (10.10.10.x) for scanning.

- My Metasploitable2 Machine is at: `10.10.10.10`

-- -

### Commands

- netcat
    
    ```
    nc 10.10.10.10 X # here x represents an open port (21, 22, 80, etc)
    ```
    
- whatweb
    
    ```
    whatweb 10.10.10.10 -v
    ```
    
- whois
    
    ```
    whois microsoft.com
    ```
    
- nslookup
    
    ```
    nslookup google.com
    ```
    
- nmap
    
    Utilize the `-T4` flag for increased scanning speed
    
    ```
    nmap 10.10.10.10 -T4
    ```
    
    ```
    nmap 10.10.10.10 -sV -T4
    ```
    
- sherlock
Only run this against an account that you own/ or have permission to! I used `hacker` as a reference, not to encourage you to repeat this.
    
    ```
    sherlock hacker
    ```
    
- netdiscover
    
    ```
    netdiscover -r 10.10.10.0/24
    ```
    
- dirb
    
    ```
    dirb http://10.10.10.10/
    ```
    
- nikto
    
    ```
    nikto -h http://10.10.10.10/
    ```
    
- Angry IP Scanner
It will automaticall fill up the IP range according to your eth0 interface, you just need to fire up the scan and wait for it to finish
