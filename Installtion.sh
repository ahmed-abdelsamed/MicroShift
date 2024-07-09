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
