+++
title = "Security | Cryptography"
date = 2020-03-19
+++

# Security

Authentication
* Who are you?
* Methods: Login form, HTTP authentication, X.509 certificates, HTTP digest, ...

Authorization
* What can i do?
* Methods: Access control for URLs, Secure objects and methods, Access control lists (ACLs)
* Types: Role-, Claims-, Policy-based authorization

SiteMinder, Single Sign-On
* SSO is a solution that allows a user to authenticate once and gain access to all applications/resources supported by the SSO, without having to sign in separately to each application/resource.
* with a SiteMinder Web Agent a client request is intercepted 
    * Web Agent is a filter on the web server
    * is the request path (resource) is protected then the request goes to Policy Server
    * the Policy Server needs the credentials (username / password) to gave access
* why use SSO / SiteMinder?
    * it acts as a single point of truth
    * otherwise the user has to login each per system (ex. apache web server, IIS windows server, ...)
* CA Single Sign-On (formerly CA SiteMinder)
* CA SiteMinder Policy Server
* CA SiteMinder authentication provider

HTTP authentication schemas
* Basic: uses the easily reversible Base64 encoding instead of hashing
* Digest: applies a hash function to the username and password before sending them over the network
* Bearer / OAuth
    * Token based authentication
    * is complementary to and distinct from ODIC
    * ODIC and OAuth are often used together
    * OAuth act as the authorization layer
* NTLM NT LAN Manager authentication is a challenge-response scheme. NTLM uses Windows credentials to transform the challenge data.

API Keys
* access REST api with a key (no user required)

JWT
* JSON Web Token: is an encrypted JSON (format)
* typicalls used with Bearer auth.

ODIC
* OpenID Connect
* OIDC providing the user _authentication layer_

Integrated Windows Authentication (IWA)
* The current Windows user information on the client computer is used by the browser.

Kerberos
* is a computer-network authentication protocol 

LDAP
* Lightweight Directory Access Protocol is a standard application protocol
* sharing of information on users, systems, networks, services, and applications
* LDAP authentication is the process of validating a username and password with a directory service using the LDAP protocol.

Links
* https://doubleoctopus.com/security-wiki/
* https://www.roytuts.com/how-siteminder-works/
* https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication
* https://docs.microsoft.com/en-us/dotnet/framework/wcf/feature-details/understanding-http-authentication
* https://docs.microsoft.com/en-us/aspnet/core/security/?view=aspnetcore-3.1
* https://cheatsheetseries.owasp.org/cheatsheets/REST_Security_Cheat_Sheet.html
* https://jwt.io/introduction/


# Cryptography
* encryption / ciphering / encoding
* we need encryption when ever we send information over unsafe networks.
* main target of cryptography
    * Confidentiality: only authorized person can read protected information
    * Authentication: you talk to the right person. you can trust.
    * Integrity: the message hasnt been changed
* encrypt a plaintext with a key and algorithm: `plaintext -> chiphertext`

### hashing
* a one-way function / fingerprint
* used e.g. for passwords. the hash of it is stored then stored.

_example: python MD5_
```py
>>> hashlib.md5(b'bob').hexdigest()
'9f9d51bc70ef21ca5c14f307980a29d8'
>>> hashlib.md5(b'bob').hexdigest()
'9f9d51bc70ef21ca5c14f307980a29d8'
```

### symmetric / asymmetric encryption
* symmetric encryption (algorithms): only _one key_ for encryption and decryption
    * problem: both user has to know the key
* asymmetric encryption / _public key cryptography_ : key pair (private key and public key)
    * the information can decrypted with private key
    * encryption with public key

### certificates: encrypted connections
For an secure connection between two nodes (e.g. client / server) we can use TLS (SSL). In order to accomblish this we need a few artifacts.

First of all we need a _SSL certificate_.

__Signed certificate__: In order to obtain a _signed_ SSL certificate we can create a private key and a _CSR_ with _OpenSSL_.

With the _key_ file we create the CSR. And with the CSR in turn we can request a signed digital certificate from an _CA_.

For the key generation you can use a common public-key cryptosystem provided in OpenSSL.


__Self-signed certificate__ is the counterpart of the CA signed certificate.

Here you just create your private key and your certificate. And use it for secure connection.

### terminology
* private key file
* CSR: Certificate Signing Request
* CA: certificate authority
