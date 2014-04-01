<div class="row profile-header-submenu">
    <div class="col-lg-12">

        <ul class="nav nav-pills">
            <li {if $sMenuSubItemSelect=='topics'}class="active"{/if}>
                <a href="{$oUserProfile->getProfileUrl()}favourites/topics/">{$aLang.user_menu_profile_favourites_topics}  {if $iCountTopicFavourite} ({$iCountTopicFavourite}) {/if}</a>
            </li>

            <li {if $sMenuSubItemSelect=='comments'}class="active"{/if}>
                <a href="{$oUserProfile->getProfileUrl()}favourites/comments/">{$aLang.user_menu_profile_favourites_comments}  {if $iCountCommentFavourite} ({$iCountCommentFavourite}) {/if}</a>
            </li>

            {hook run='menu_profile_favourite_item' oUserProfile=$oUserProfile}
        </ul>

        {hook run='menu_profile_favourite' oUserProfile=$oUserProfile}

    </div>
</div>
