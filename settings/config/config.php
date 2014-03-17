<?php

$config['smarty']['dir']['templates'] = array(
    'themes' => '___path.skins.dir___/___view.skin___/themes/',
    'tpls'   => '___path.skins.dir___/___view.skin___/tpls/',
);

/* Theme */
$config['view']['theme'] = 'default';
//$config['view']['header']['top'] = 'static'; // static or fixed
$config['view']['header']['top'] = 'fixed'; // static or fixed
$config['view']['header']['banner'] = true;

$config['head']['default']['js'] = Config::Get('head.default.js');
$config['head']['default']['js'][] = '___path.skin.url___/assets/js/template.js';

/* Bootstrap */
$config['head']['default']['js']['___path.skin.url___/assets/bootstrap/js/bootstrap.min.js'] = array('name' => 'bootstrap');


$config['head']['default']['css'] = array(
    /* Bootstrap */
    '___path.skin.url___/assets/bootstrap/css/bootstrap.min.css',

    /* Structure */
    '___path.skin.url___/assets/css/base.css',
    '___path.frontend.dir___/libs/vendor/markitup/skins/default/style.css',
    '___path.frontend.dir___/libs/vendor/markitup/sets/default/style.css',
    '___path.frontend.dir___/libs/vendor/jcrop/jquery.Jcrop.css',
    '___path.frontend.dir___/libs/vendor/prettify/prettify.css',
    '___path.frontend.url___/libs/vendor/nprogress/nprogress.css',
    '___path.frontend.url___/libs/vendor/syslabel/syslabel.css',
    '___path.frontend.url___/libs/vendor/prettyphoto/css/prettyphoto.css',
    '___path.skin.url___/assets/css/smoothness/jquery-ui.css',
    '___path.skin.url___/assets/css/responsive.css',

    /* Theme */
    '___path.skin.url___/themes/___view.theme___/style.css',
    /* Themer Icons */
    '___path.skin.url___/assets/icons/css/fontello.css',
);

return $config;

// EOF