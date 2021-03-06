+++
title = "SSE: Server-Sent Events"
date = 2021-03-02
+++

# About 
This document gives an overview about SSE. What is it. When to use. The Terminology.

# Introduction
As the abbr. suggests the concept behind SSE is that the server is sending data _asynchronously_ to client.
The connection client-server is done _once_.

This approach differs from the well-known concept of client-server communication.
Where client does a request to a server and the server responses to client.
The difference to SSE is that the initiation is done by the client. 
The client has to request for new data.

![](../client-server.png)

Whereas in the SSE concept the server initiates.

The client on the other side should react to the stream of events.
It's a kind of _broadcast_ mechanism where clients _subscribes_ to the server events.
SSE can be clustered together with Kafka, JMS in the umbrella term _reactive messaging_.

![](../sse.png)

# Implementation
In order to use SSE in your implementation you need a SSE client API (javascript API, Jersey Client SSE API, Microprofile, ...)

# TODO
* data source: sender, data sink: receiver
* use SSE for simple messaging, or as data sink of a kafka architecture (kafka -> SSE: see links)

# Links
* https://eclipse-ee4j.github.io/jersey.github.io/documentation/latest/sse.html
* https://openliberty.io/guides/reactive-messaging-sse.html
* https://download.eclipse.org/microprofile/microprofile-reactive-messaging-1.0/microprofile-reactive-messaging-spec.html
* drawing made with: https://excalidraw.com/
