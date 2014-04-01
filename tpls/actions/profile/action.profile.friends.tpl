{extends file="_profile.tpl"}

{block name="layout_vars"}
    {$menu="people"}
{/block}

{block name="layout_profile_content"}

{include file='user_list.tpl' aUsersList=$aFriends}

{/block}
