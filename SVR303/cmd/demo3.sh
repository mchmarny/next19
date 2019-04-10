curl -H "Content-Type: application/json" \
     -d '{ "id": "logo1", "url": "https://storage.googleapis.com/kdemo-logos/k8s.png" }' \
     -X POST https://klogo.next.demome.tech/ | jq "."