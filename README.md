# Install Concourse and Minio using bosh-cli2 and Vagrant

Currently bosh-cli2 support on Windows is limited so if you are stuck with a Windows environment this Vagrant project will help you get going. Note, this approach utilises the [non-recommended Vagrant based bosh-lite](https://github.com/cloudfoundry/bosh-lite/blob/master/docs/README.md). You can also run this Vagrant project on other platform such as Linux without any issues if you wish.

The setup consists of 2 VMs
1. *bosh-lite*: initially a pre-defined vagrantbox, running bosh-director, configured to simulate VMs with warden-containers. After installation has been completed, this VM will also contain Concourse and Minio.  
2. *cli-vm*: an Ubuntu Linux box with bosh-cli v2 [bosh-cli2-v2](https://bosh.io/docs/cli-v2) and [fly-cli](http://concourse.ci/fly-cli.html)

## Prerequisites
* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Install [Vagrant](https://www.vagrantup.com/downloads.html)

## Instructions
1. Run the following script to ensure you can access to Concourse and Minio from your local machine.

  Windows (run as admin):

   ```
   $ ./route-add.bat
   ```
   Linux (run as sudo):
   ```
   $ sudo ./route-add.sh
   ```

2. Start the Vagrant project. Note, this will take a couple of minutes the first time you run it as it will need to download/install a number of components:

   ```
   $ ./vagrant up
   ```

3. Once started you can ssh into the *cli-vm* image to start interacting with Concourse via the [fly-cli](http://concourse.ci/fly-cli.html):

   ```
   $ ./vagrant ssh cli-vm
   ```

4. To pause your Concourse and Minio VMs you can run the following command:

   ```
   $ ./vagrant suspend
   ```

5. To resume your Concourse and Minio VMs you can run the following command:

   ```
   $ ./vagrant resume
   ```

6. To access Concoure & Minio you can connect to the following addresses:

    Concourse: http://10.244.15.2:8080/

    Minio: http://10.244.15.3:9000/ (User/Pass: minio/minio123)
