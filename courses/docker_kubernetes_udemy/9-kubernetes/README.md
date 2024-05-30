

kubectl create deployment first-kube --image=felixsteph/kube-first

minikube service kube-first

kb get pods

kb scale deployment/kube-first --replicas=1