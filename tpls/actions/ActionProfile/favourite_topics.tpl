{extends file="_index.tpl"}

{block name="layout_vars"}
    {$menu="people"}
{/block}

{block name="layout_content"}
    <div class="action-header">
        {include file='actions/ActionProfile/profile_top.tpl'}
        {include file='menus/menu.profile_favourite.tpl'}
    </div>
    {if E::UserId()==$oUserProfile->getId()}
        {widget name="TagsFavouriteTopic" user=$oUserProfile}
    {/if}

    {include file='topics/topic.list.tpl'}

{/block}
