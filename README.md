# Log Aggregation with Elastic-Stack 

#### This is a sample repo with example of how to ship Linux system logs and application logs (nginx) with Logstash and Filebeat to Elasticsearch and make a visualization with Kibana

### Pre-requisits

- vagrant
- git
- virtualbox

### High level overview

<img src="diagrams/elastic-stack.png" />

## How to run

#### Get the repo

```
git clone https://github.com/achuchulev/elastic-stack.git
cd elastic-stack
vagrant up
```

- `Vagrant up` will spin 2 VMs: 

  - elastic VM: Filebeat, Elasticsearch and Kibana - Filebeat collect all system logs and ship them to Elasticsearch
  - nginx VM: Nginx and Logstash - Logstash ship nginx logs to Elasticsearch

- All logs are shiped to Elasticsearch where being indexed. Kibana provides powerfull interface that lets us visualize our Elasticsearch data.

## How to use

- We need to first provide a pattern of index for kibana to do query against elasticsearch. We are using filebeat for the system logs and logstash for the nginx logs

<img src="diagrams/patterns.png" />

- Once the pattern/index name is saved, the kibana interface should show you log events on the dashboard as shown below.

<img src="diagrams/indexes.png" />

