# nexus_infra
Definition and configuration of the Nexus infrastructure.

## Deployments

A deployment is done according to two criteria: stage and environment.

There are currently two stages. The first one defines the underlying infrastructure, such as networks and which services must be deployed (Kubernetes, MongoDB, etc.). The second stage depends on the first one, and adds complementary configuration on top of it. For instance, the Kubernetes namespace for Nexus is defined in the second stage, as it needs the Kubernetes cluster to be created.

There is currently only one environment (dev), although more are planned in the future (tst, stg, prd).