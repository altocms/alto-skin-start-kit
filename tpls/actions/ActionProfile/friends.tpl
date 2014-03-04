{extends file="_index.tpl"}

{block name="layout_vars"}
    {$menu="people"}
{/block}

{block name="layout_content"}

{include file='actions/ActionProfile/profile_top.tpl'}

{include file='user_list.tpl' aUsersList=$aFriends}

{/block}
