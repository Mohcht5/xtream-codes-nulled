# استخدم صورة Ubuntu LTS الأساسية
FROM ubuntu:20.04

# تحديث المستودعات أولاً
RUN apt-get update && apt-get upgrade -y

# إضافة مستودعات PHP 5.6
RUN add-apt-repository ppa:ondrej/php -y && apt-get update

# تثبيت الحزم المطلوبة
RUN apt-get install -y \
    software-properties-common \
    curl \
    unzip \
    iptables-persistent \
    apache2 \
    php5.6 \
    php5.6-cli \
    php5.6-mysql \
    php5.6-curl \
    php5.6-mcrypt \
    && apt-get clean

# تمكين مكون PHP mcrypt
RUN phpenmod mcrypt

# تنزيل ملفات الإعداد
RUN wget https://github.com/amin015/xtream-codes-nulled/raw/refs/heads/master/iptv_panel_pro.zip -O /tmp/iptv_panel_pro.zip
RUN wget https://github.com/amin015/xtream-codes-nulled/raw/refs/heads/master/install_iptv_pro.php -O /tmp/install_iptv_pro.php

# فك ضغط الملفات
RUN unzip /tmp/iptv_panel_pro.zip -d /var/www/html
RUN php /tmp/install_iptv_pro.php

# فتح المنفذ 80 (منفذ الويب الافتراضي لـ Apache)
EXPOSE 80

# بدء Apache عند تشغيل الحاوية
CMD ["apache2ctl", "-D", "FOREGROUND"]
