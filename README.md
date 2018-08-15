# Adding realtime functionality to a blog using Kubeless and Pusher

Serverless architectures are becoming very popular. This repository demonstrates a Serverless application - using Kubeless - and how to easily add components to it.

This repository is discussed at [Adding realtime functionality to a blog using Kubeless and Pusher](https://pusher.com/tutorials/realtime-blog-kubeless).

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

In order to use this, you will need a Docker system with Kubernetes installed, and a working installation of Node.js.

### Setting up

Firstly, you will need to update `broadcast-article/index.js` and `ui/src/ArticleList.js` to have correct Pusher Channels credentials.

Then, to build the Kubeless system you can simply execute `./setup.sh` and to tear it down afterwards run `./cleanup.sh`.

Finally, to build the UI you can execute `npm install` or `yarn install` from inside the `ui` directory, and to start it you can run `npm start` or `yarn start`.

## Built With

* [Pusher](https://pusher.com/) - APIs to enable devs building realtime features
* [Docker](https://www.docker.com/) - Docker is an open platform for developers and sysadmins to build, ship, and run distributed applications, whether on laptops, data center VMs, or the cloud.
* [Kubernetes](https://kubernetes.io/) - Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.
* [Kubeless](https://kubeless.io/) - The Kubernetes Native Serverless Framework
* [Node.js](https://nodejs.org/en/) - Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine.



