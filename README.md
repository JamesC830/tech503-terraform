# Terraform notes

- ***Orchistration tool***: Sees instances as immutible (can't be changed)
- ***Easy to use***
- ***Open-source***:
  - ***Free***
  - ***Customisatable***
  - ***Community***: Documentation, collaborative
- ***Declaritive***: Describe what you want to achive, not how to do it
- ***Cloud agnostic***: Can be used with any cloud provider
- ***Expressive and extendible***: "Expressive" refers to a language's ability to express ideas and concepts in a concise and clear manner, often with features like syntactic sugar or powerful libraries. "Extensible" means a language allows programmers to add new features and functionality, potentially extending the language's core capabilities

Alternatives:
- Pulumi: Imperative
- AWS Cloud formation: AWS specific service
- Chef: Mainly config management service
- Puppet: Mainly config management service

**Production** | **Test** | **Disaster recovery** |
------|----------|----
scale | Quick | Automated failover
consistency | Reproducible |
compliance | Automation |

## Workflow
```terraform init```

Sets the groundwork, like git init

```terraform plan```

Previews the plan of what you are asking. Compares that with the current state.

```terraform apply```

Applies the plan. Updates the state file with the current state of the infrastructure

```terraform destroy```

Destroys all resources currently defined in terraform state