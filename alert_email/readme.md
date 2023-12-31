centos 7.9 配置email工具

1. 安装mail工具

  ```
  yum install mailx -y
  ```

2. 配置文件

  ```
  vim /etc/mail.rc
  ```

  将以下内容键入配置文件中

  ```
  # 指定邮箱
  set from=jacksoulmate@163.com
  
  # 邮箱协议
  set smtp=smtps://smtp.163.com:465
  
  # 邮箱账号
  set smtp-auth-user="jacksoulmate@163.com"
  
  # 邮箱授权码
  set smtp-auth-password="HTAORGBTYCIHIVOY"
  
  # 登陆方式
  set smtp-auth=login
  
  #ssl登陆方式
  set ssl-verify=ignore
  
  #ssl证书
  set nss-config-dir=/root/.certs/
  ```

3. 创建证书目录（在使用用户所需目录）

  ```
  mkdir -p ~/.certs/
  ```

  ```
  [root@VM-16-10-centos]# echo -n | openssl s_client -connect smtp.163.com:465 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ~/.certs/163.crt
  depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root CA
  verify return:1
  depth=1 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = GeoTrust CN RSA CA G1
  verify return:1
  depth=0 C = CN, ST = Zhejiang, L = Hangzhou, O = "NetEase (Hangzhou) Network Co., Ltd", OU = IT Dept., CN = *.163.com
  verify return:1
  DONE
  ```

  导入ssl库

  ```
  certutil -A -n "GeoTrust SSL CA" -t "C,," -d ~/.certs -i ~/.certs/163.crt
  ```

  导入全局库

  ```
  certutil -A -n "GeoTrust Global CA" -t "C,," -d ~/.certs -i ~/.certs/163.crt
  ```

  执行

  ```
  [root@VM-16-10-centos]# certutil -L -d /root/.certs
   
  Certificate Nickname                                         Trust Attributes
                                                               SSL,S/MIME,JAR/XPI
   
  GeoTrust SSL CA                                              C,,  
  ```

  切到证书目录下 

  ```
  cd /~/.certs/
  ```

  ```
  [root@VM-16-10-centos .certs]# certutil -A -n "GeoTrust SSL CA - G3" -t "Pu,Pu,Pu"  -d ./ -i 163.crt
  Notice: Trust flag u is set automatically if the private key is present.
  ```

  4. 执行邮件发送测试

  ```
  echo 'hello' |mail -v -s "test" 25XXXXXXXX@qq.com
  ```

