Installing Red Hat build of MicroShift
This document provides information to help you get deploy MicroShift on VM Install Red Hat build of MicroShift from an RPM package on a machine with Red Hat Enterprise Linux (RHEL 9)

System Requirement
The following conditions must be met prior to installing Red Hat build of MicroShift:
•	RHEL 9
•	2 CPU cores
•	4 GB of RAM
•	10 GB of storage

Installing Red Hat build of MicroShift from an RPM package
sudo subscription-manager repos --enable  rhocp-4.16-for-rhel-9-x86_64-rpms --enable fast-datapath-for-rhel-9-x86_64-rpms

sudo dnf install -y microshift

sudo systemctl enable microshift
sudo systemctl start microshift

#copy the pull secret to the /etc/crio folder of your RHEL machine, run the following command:

vi /etc/crio/openshift-pull-secret
sudo chown root:root /etc/crio/openshift-pull-secret
sudo chmod 600 /etc/crio/openshift-pull-secret

# Firewall
sudo firewall-cmd --permanent --zone=trusted --add-source=10.42.0.0/16
sudo firewall-cmd --permanent --zone=trusted --add-source=169.254.169.1
sudo firewall-cmd --reload


### How to access the Red Hat build of MicroShift cluster
mkdir -p ~/.kube/

## Access locally only
sudo cat /var/lib/microshift/resources/kubeadmin/kubeconfig > ~/.kube/config

## Access Remotelly
 sudo cat /var/lib/microshift/resources/kubeadmin/microshift.linkdev.local/kubeconfig  > ~/.kube/config


sudo chmod go-r ~/.kube/config

### Verify that RedHat build of microshift is running

[root@microshift ~]# oc get all -A
NAMESPACE                  NAME                                           READY   STATUS    RESTARTS        AGE
kube-system                pod/csi-snapshot-controller-69cdb47db9-9wmgj   1/1     Running   2 (2m56s ago)   5m28s
kube-system                pod/csi-snapshot-webhook-84756f8dc-hpt4l       1/1     Running   0               5m25s
openshift-dns              pod/dns-default-zczk8                          2/2     Running   0               4m8s
openshift-dns              pod/node-resolver-zwrzd                        1/1     Running   0               5m28s
openshift-ingress          pod/router-default-8699b5bc5c-n48dt            1/1     Running   1 (88s ago)     5m26s
openshift-ovn-kubernetes   pod/ovnkube-master-qmt6c                       4/4     Running   1 (4m10s ago)   5m28s
openshift-ovn-kubernetes   pod/ovnkube-node-jwjt8                         1/1     Running   1 (4m11s ago)   5m28s
openshift-service-ca       pod/service-ca-6dbc4646f9-gmtrd                1/1     Running   2 (2m37s ago)   5m25s
openshift-storage          pod/topolvm-controller-7ffddf6465-2hdsh        5/5     Running   1 (3m9s ago)    5m28s
openshift-storage          pod/topolvm-node-5qg2x                         3/3     Running   1 (3m7s ago)    4m8s

NAMESPACE           NAME                              TYPE           CLUSTER-IP      EXTERNAL-IP                                                       PORT(S)                      AGE
default             service/kubernetes                ClusterIP      10.43.0.1       <none>                                                            443/TCP                      6m11s
kube-system         service/csi-snapshot-webhook      ClusterIP      10.43.111.161   <none>                                                            443/TCP                      5m48s
openshift-dns       service/dns-default               ClusterIP      10.43.0.10      <none>                                                            53/UDP,53/TCP,9154/TCP       5m28s
openshift-ingress   service/router-default            LoadBalancer   10.43.12.222    10.42.0.2,10.44.0.0,192.168.100.100,192.168.122.1,192.168.130.1   80:32206/TCP,443:31941/TCP   5m28s
openshift-ingress   service/router-internal-default   ClusterIP      10.43.246.252   <none>                                                            80/TCP,443/TCP,1936/TCP      5m28s

NAMESPACE                  NAME                            DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
openshift-dns              daemonset.apps/dns-default      1         1         1       1            1           kubernetes.io/os=linux   5m28s
openshift-dns              daemonset.apps/node-resolver    1         1         1       1            1           kubernetes.io/os=linux   5m28s
openshift-ovn-kubernetes   daemonset.apps/ovnkube-master   1         1         1       1            1           kubernetes.io/os=linux   5m28s
openshift-ovn-kubernetes   daemonset.apps/ovnkube-node     1         1         1       1            1           kubernetes.io/os=linux   5m28s
openshift-storage          daemonset.apps/topolvm-node     1         1         1       1            1           <none>                   5m28s

NAMESPACE              NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system            deployment.apps/csi-snapshot-controller   1/1     1            1           5m48s
kube-system            deployment.apps/csi-snapshot-webhook      1/1     1            1           5m38s
openshift-ingress      deployment.apps/router-default            1/1     1            1           5m28s
openshift-service-ca   deployment.apps/service-ca                1/1     1            1           5m58s
openshift-storage      deployment.apps/topolvm-controller        1/1     1            1           5m28s

NAMESPACE              NAME                                                 DESIRED   CURRENT   READY   AGE
kube-system            replicaset.apps/csi-snapshot-controller-69cdb47db9   1         1         1       5m38s
kube-system            replicaset.apps/csi-snapshot-webhook-84756f8dc       1         1         1       5m28s
openshift-ingress      replicaset.apps/router-default-8699b5bc5c            1         1         1       5m28s
openshift-service-ca   replicaset.apps/service-ca-6dbc4646f9                1         1         1       5m48s
openshift-storage      replicaset.apps/topolvm-controller-7ffddf6465        1         1         1       5m28s

[root@microshift ~]# oc get nodes
NAME                       STATUS   ROLES                         AGE    VERSION
microshift.linkdev.local   Ready    control-plane,master,worker   6m9s   v1.29.6



[root@microshift ~]# oc get pods -A
NAMESPACE                  NAME                                       READY   STATUS    RESTARTS      AGE
kube-system                csi-snapshot-controller-69cdb47db9-9wmgj   1/1     Running   2 (24m ago)   26m
kube-system                csi-snapshot-webhook-84756f8dc-hpt4l       1/1     Running   0             26m
openshift-dns              dns-default-zczk8                          2/2     Running   0             25m
openshift-dns              node-resolver-zwrzd                        1/1     Running   0             26m
openshift-ingress          router-default-8699b5bc5c-n48dt            1/1     Running   1 (22m ago)   26m
openshift-ovn-kubernetes   ovnkube-master-qmt6c                       4/4     Running   1 (25m ago)   26m
openshift-ovn-kubernetes   ovnkube-node-jwjt8                         1/1     Running   1 (25m ago)   26m
openshift-service-ca       service-ca-6dbc4646f9-gmtrd                1/1     Running   2 (23m ago)   26m
openshift-storage          topolvm-controller-7ffddf6465-2hdsh        5/5     Running   1 (24m ago)   26m
openshift-storage          topolvm-node-5qg2x                         3/3     Running   1 (24m ago)   25m
