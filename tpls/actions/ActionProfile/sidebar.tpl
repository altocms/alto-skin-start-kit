{hook run='profile_sidebar_begin' oUserProfile=$oUserProfile}

<section class="panel panel-default block block-type-profile">
    <div class="panel-body">

        <div class="profile-photo-wrapper">
            <span class="label {if $oUserProfile->isOnline()}label-success{else}label-danger{/if} status">
                {if $oUserProfile->isOnline()}{$aLang.user_status_online}{else}{$aLang.user_status_offline}{/if}
            </span>
            <img src="{$oUserProfile->getPhotoUrl()}" alt="photo" class="profile-photo" id="foto-img"/>
        </div>

        {if $sAction=='settings' AND E::UserId() == $oUserProfile->getId()}
            <script type="text/javascript">
                jQuery(function ($) {
                    $('#foto-upload').file({ name: 'foto' }).choose(function (e, input) {
                        ls.user.uploadFoto(null, input);
                    });
                });
            </script>
            <p class="small upload-photo">
                <a href="#" id="foto-upload"
                   class="link-dotted">{if E::User()->getProfilePhoto()}{$aLang.settings_profile_photo_change}{else}{$aLang.settings_profile_photo_upload}{/if}</a>&nbsp;&nbsp;&nbsp;
                <a href="#" id="foto-remove" class="link-dotted" onclick="return ls.user.removeFoto();"
                   style="{if !E::User()->getProfilePhoto()}display:none;{/if}">{$aLang.settings_profile_foto_delete}</a>
            </p>
            <div class="modal fade in modal-upload-photo" id="foto-resize">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <header class="modal-header">
                            <h4 class="modal-title">{$aLang.uploadimg}</h4>
                        </header>

                        <div class="modal-body">
                            <img src="" alt="" id="foto-resize-original-img"><br/>
                            <button type="submit" class="btn btn-success"
                                    onclick="return ls.user.resizeFoto();">{$aLang.settings_profile_avatar_resize_apply}</button>
                            <button type="submit" class="btn btn-default"
                                    onclick="return ls.user.cancelFoto();">{$aLang.settings_profile_avatar_resize_cancel}</button>
                        </div>

                    </div>
                </div>
            </div>
        {/if}

    </div>
</section>

{hook run='profile_sidebar_menu_before' oUserProfile=$oUserProfile}

<section class="panel panel-default block block-type-profile-nav">
    <div class="panel-body">

        <ul class="nav nav-pills nav-stacked">
            {hook run='profile_sidebar_menu_item_first' oUserProfile=$oUserProfile}
            <li {if $sAction=='profile' AND ($aParams[0]=='whois' OR $aParams[0]=='')}class="active"{/if}><a
                        href="{$oUserProfile->getProfileUrl()}">{$aLang.user_menu_profile_whois}</a></li>
            <li {if $sAction=='profile' AND $aParams[0]=='wall'}class="active"{/if}><a
                        href="{$oUserProfile->getProfileUrl()}wall/">{$aLang.user_menu_profile_wall}{if ($iCountWallUser)>0}
                        <span class="badge pull-right">{$iCountWallUser}</span>{/if}</a></li>
            <li {if $sAction=='profile' AND $aParams[0]=='created'}class="active"{/if}><a
                        href="{$oUserProfile->getProfileUrl()}created/topics/">{$aLang.user_menu_publication}{if ($iCountCreated)>0}
                        <span class="badge pull-right">{$iCountCreated}</span>{/if}</a></li>
            <li {if $sAction=='profile' AND $aParams[0]=='favourites'}class="active"{/if}><a
                        href="{$oUserProfile->getProfileUrl()}favourites/topics/">{$aLang.user_menu_profile_favourites}{if ($iCountFavourite)>0}
                        <span class="badge pull-right">{$iCountFavourite}</span>{/if}</a></li>
            <li {if $sAction=='profile' AND $aParams[0]=='friends'}class="active"{/if}><a
                        href="{$oUserProfile->getProfileUrl()}friends/">{$aLang.user_menu_profile_friends}{if ($iCountFriendsUser)>0}
                        <span class="badge pull-right">{$iCountFriendsUser}</span>{/if}</a></li>
            <li {if $sAction=='profile' AND $aParams[0]=='stream'}class="active"{/if}><a
                        href="{$oUserProfile->getProfileUrl()}stream/">{$aLang.user_menu_profile_stream}</a></li>

            {if E::UserId() == $oUserProfile->getId()}
                <li {if $sAction=='talk'}class="active"{/if}><a
                            href="{router page='talk'}">{$aLang.talk_menu_inbox}{if $iUserCurrentCountTalkNew}<span
                                class="badge pull-right">{$iUserCurrentCountTalkNew}</span>{/if}</a></li>
                <li {if $sAction=='settings'}class="active"{/if}><a
                            href="{router page='settings'}">{$aLang.settings_menu}</a></li>
            {/if}
            {hook run='profile_sidebar_menu_item_last' oUserProfile=$oUserProfile}
        </ul>

    </div>
</section>

{if E::User() AND E::UserId()!=$oUserProfile->getId()}
    <script type="text/javascript">
        jQuery(function ($) {
            ls.lang.load({lang_load name="profile_user_unfollow,profile_user_follow"});
        });
    </script>
    <section class="panel panel-default block block-type-profile-actions">
        <div class="panel-body">

            <div class="block-content">
                <ul class="list-unstyled profile-actions" id="profile_actions">
                    {include file='actions/ActionProfile/friend_item.tpl' oUserFriend=$oUserProfile->getUserFriend()}
                    <li>
                        <a href="{router page='talk'}add/?talk_users={$oUserProfile->getLogin()}">{$aLang.user_write_prvmsg}</a>
                    </li>
                    <li>
                        <a href="#" onclick="ls.user.followToggle(this, {$oUserProfile->getId()}); return false;"
                           class="{if $oUserProfile->isFollow()}followed{/if}">
                            {if $oUserProfile->isFollow()}{$aLang.profile_user_unfollow}{else}{$aLang.profile_user_follow}{/if}
                        </a>
                    </li>
                </ul>
            </div>

        </div>
    </section>
{/if}

{if E::IsUser() AND E::UserId() != $oUserProfile->getId()}
    <section class="panel panel-default block block-type-profile-note">
        <div class="panel-body">

            {if $oUserNote}
                <script type="text/javascript">
                    ls.usernote.sText = {json var = $oUserNote->getText()};
                </script>
            {/if}

            <div id="usernote-note" class="profile-note" {if !$oUserNote}style="display: none;"{/if}>
                <p id="usernote-note-text">
                    {if $oUserNote}
                        {$oUserNote->getText()}
                    {/if}
                </p>

                <ul class="list-unstyled list-inline actions">
                    <li><a href="#" onclick="return ls.usernote.showForm();"
                           class="link-dotted">{$aLang.user_note_form_edit}</a></li>
                    <li><a href="#" onclick="return ls.usernote.remove({$oUserProfile->getId()});"
                           class="link-dotted">{$aLang.user_note_form_delete}</a></li>
                </ul>
            </div>

            <div id="usernote-form" style="display: none;">
                <div class="form-group">
                    <textarea rows="4" cols="20" id="usernote-form-text" class="form-control"></textarea>
                </div>
                <button type="submit" onclick="return ls.usernote.save({$oUserProfile->getId()});"
                        class="btn btn-success">{$aLang.user_note_form_save}</button>
                <button type="submit" onclick="return ls.usernote.hideForm();"
                        class="btn btn-default">{$aLang.user_note_form_cancel}</button>
            </div>

            <a href="#" onclick="return ls.usernote.showForm();" id="usernote-button-add" class="link-dotted"
               {if $oUserNote}style="display:none;"{/if}>{$aLang.user_note_add}</a>

        </div>
    </section>
{/if}

{hook run='profile_sidebar_end' oUserProfile=$oUserProfile}
