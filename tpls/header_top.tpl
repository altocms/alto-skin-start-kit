<header id="header" role="banner">

    {hook run='header_top_begin'}

    <nav class="navbar navbar-inverse navbar-{Config::Get('view.header.top')}-top">
        <div class="container">

            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

                <hgroup class="site-info">
                    <h1 class="site-name"><a class="navbar-brand" href="{Config::Get('path.root.url')}">{Config::Get('view.name')}</a></h1>
                </hgroup>
            </div>

            {hook run='userbar_nav'}

            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav">
                    <li {if $sMenuHeadItemSelect=='blog'}class="active"{/if}><a href="{Config::Get('path.root.url')}">{$aLang.topic_title}</a></li>
                    <li {if $sMenuHeadItemSelect=='blogs'}class="active"{/if}><a href="{router page='blogs'}">{$aLang.blogs}</a></li>
                    <li {if $sMenuHeadItemSelect=='people'}class="active"{/if}><a href="{router page='people'}">{$aLang.people}</a></li>
                    <li {if $sMenuHeadItemSelect=='stream'}class="active"{/if}><a href="{router page='stream'}">{$aLang.stream_menu}</a></li>

                    {hook run='main_menu_item'}
                </ul>

                {hook run='main_menu'}

                <ul class="nav navbar-nav navbar-right">
                    {if E::IsUser()}
                        {if $iUserCurrentCountTalkNew}
                            <li>
                                <a href="{router page='talk'}" class="new-messages" title="{if $iUserCurrentCountTalkNew}{$aLang.user_privat_messages_new}{/if}">
                                    {$iUserCurrentCountTalkNew} <span class="glyphicon glyphicon-envelope"></span>
                                </a>
                            </li>
                        {/if}
                        <li class="dropdown nav-userbar">
                            <a data-toggle="dropdown" data-target="#" href="{E::User()->getProfileUrl()}" class="dropdown-toggle username">
                                <img src="{E::User()->getAvatarUrl(24)}" alt="{E::User()->getDisplayName()}" class="avatar"/>
                                {E::User()->getDisplayName()}
                                <b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="{E::User()->getProfileUrl()}">{$aLang.user_menu_profile}</a>
                                </li>
                                <li><a href="{router page='talk'}" id="new_messages"  title="{if $iUserCurrentCountTalkNew}{$aLang.user_privat_messages_new}{/if}">
                                        {$aLang.user_privat_messages}
                                        {if $iUserCurrentCountTalkNew} <span class="new-messages">+{$iUserCurrentCountTalkNew}</span>{/if}</a>
                                </li>
                                <li>
                                    <a href="{E::User()->getProfileUrl()}wall/">{$aLang.user_menu_profile_wall}</a>
                                </li>
                                <li>
                                    <a href="{E::User()->getProfileUrl()}created/topics/">{$aLang.user_menu_publication}</a>
                                </li>
                                <li>
                                    <a href="{E::User()->getProfileUrl()}favourites/topics/">{$aLang.user_menu_profile_favourites}</a>
                                </li>
                                <li>
                                    <a href="{router page='settings'}profile/">{$aLang.user_settings}</a>
                                </li>
                                {hook run='userbar_item'}
                                <li>
                                    <a href="{router page='login'}exit/?security_key={$ALTO_SECURITY_KEY}">{$aLang.exit}</a>
                                </li>
                            </ul>
                        </li>
                    {else}
                        {hook run='userbar_item'}
                        <li>
                            <a href="{router page='login'}" class="js-modal-auth-login">{$aLang.user_login_submit}</a>
                        </li>
                        <li class="hidden-sm">
                            <a href="{router page='registration'}" class="js-modal-auth-registration">{$aLang.registration_submit}</a>
                        </li>
                    {/if}
                </ul>
            </div>

        </div>
    </nav>

    {hook run='header_top_end'}

</header>
