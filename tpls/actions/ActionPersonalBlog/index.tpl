{extends file="_index.tpl"}

{block name="layout_vars"}
    {$menu="blog"}
{/block}

{block name="layout_content"}
{include file='topics/topic.list.tpl'}
{/block}
