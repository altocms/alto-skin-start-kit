{extends file="_index.tpl"}

{block name="layout_vars"}
    {$menu="people"}
{/block}

{block name="layout_content"}

    <div class="action-header">
        {include file='actions/ActionProfile/profile_top.tpl'}
        {include file='menus/menu.profile_favourite.tpl'}
    </div>

    {include file='comment_list.tpl'}

{/block}
