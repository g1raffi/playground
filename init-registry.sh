#! /bin/bash
# publish the platform to the registry
jbang catalog_publish.java --working-directory=. --registry-url=http://localhost:8085 --token=d53298e5075c7ece3f39925aeb52ab4e --all
