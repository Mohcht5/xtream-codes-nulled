# استخدم صورة Ubuntu LTS الأساسية
FROM ubuntu:20.04

# تحديث الحزم وتثبيت الأدوات الأساسية
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    software-properties-common \
    curl \
    unzip \
    iptables-persistent \
    php5.6 \
    php5.6-mysql \
    php5.6-curl \
    php5.6-mcrypt \
    apache2 \
    && apt-get clean

# إضافة مستودعات PHP القديمة (مثل PHP 5.6) إذا كنت بحاجة إليها
RUN add-apt-repository ppa:ondrej/php && apt-get update

# تمكين المكون الإضافي mcrypt و إعادة تشغيل Apache
RUN phpenmod mcrypt && service apache2 restart

# تحميل الملفات المطلوبة
RUN wget https://github.com/amin015/xtream-codes-nulled/raw/refs/heads/master/iptv_panel_pro.zip -O /tmp/iptv_panel_pro.zip
RUN wget https://github.com/amin015/xtream-codes-nulled/raw/refs/heads/master/install_iptv_pro.php -O /tmp/install_iptv_pro.php

# فك ضغط الملفات
RUN unzip /tmp/iptv_panel_pro.zip -d /var/www/html
RUN php /tmp/install_iptv_pro.php

# فتح المنفذ 80 (منفذ الويب الافتراضي لـ Apache)
EXPOSE 80

# بدء Apache عند تشغيل الحاوية
CMD ["apache2ctl", "-D", "FOREGROUND"]
