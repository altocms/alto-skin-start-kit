<?php

$config['widgets'][] = array(
    'name' => 'toolbar_admin.tpl',
    'wgroup' => 'toolbar',
    'priority' => 'top',
);

$config['widgets'][] = array(
    'name' => 'toolbar_scrollup.tpl',
    'wgroup' => 'toolbar',
    'priority' => -100,
);

$config['widgets'][] = array(
    'name' => 'actions/ActionPeople/sidebar.tpl',
    'wgroup' => 'right',
    'on' => 'people',
);

// EOF