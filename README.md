<img src="https://gap.surati.io/img/logo.png" width="64px" height="64px"/>

[![EO principles respected here](https://www.elegantobjects.org/badge.svg)](https://www.elegantobjects.org)
[![DevOps By Rultor.com](http://www.rultor.com/b/gap-enterprise/payment-base-module)](http://www.rultor.com/p/gap-enterprise/payment-base-module)
[![We recommend IntelliJ IDEA](https://www.elegantobjects.org/intellij-idea.svg)](https://www.jetbrains.com/idea/)

[![Javadoc](http://www.javadoc.io/badge/io.surati.gap/payment-base-module.svg)](http://www.javadoc.io/doc/io.surati.gap/payment-base-module)
[![License](https://img.shields.io/badge/License-Surati-important.svg)](https://github.com/gap-enterprise/payment-base-module/blob/master/LICENSE.txt)
[![codecov](https://codecov.io/gh/gap-enterprise/payment-base-module/branch/master/graph/badge.svg)](https://codecov.io/gh/gap-enterprise/payment-base-module)
[![Hits-of-Code](https://hitsofcode.com/github/gap-enterprise/payment-base-module)](https://hitsofcode.com/view/github/gap-enterprise/payment-base-module)
[![Maven Central](https://img.shields.io/maven-central/v/io.surati.gap/payment-base-module.svg)](https://maven-badges.herokuapp.com/maven-central/io.surati.gap/payment-base-module)
[![PDD status](http://www.0pdd.com/svg?name=gap-enterprise/payment-base-module)](http://www.0pdd.com/p?name=gap-enterprise/payment-base-module)

This module shows the minimum information about payments (setup and history).

# How to run the project
Firstly, you must create a PostgreSQL database (`db_gap` by example) and host it at a PostgreSQL instance (reachable locally by example at port `5070`).

Then, you can run the application at port `9090` with Maven like this:
```shell
mvn clean integration-test -Phit-refresh -Dport=9090 -Dpgsql.dbname=db_gap -Dpgsql.user=gap -Dpgsql.password=admin -Dpgsql.host=127.0.0.1 -Dpgsql.port=5070
```
