{extends file="_index.tpl"}

{block name="layout_vars"}
    {$menu="people"}
{/block}

{block name="layout_content"}

    {include file='actions/ActionProfile/profile_top.tpl'}

    {if count($aStreamEvents)}
        <ul class="list-unstyled stream-list" id="stream-list">
            {include file='actions/ActionStream/events.tpl'}
        </ul>
        {if !$bDisableGetMoreButton}
            <input type="hidden" id="stream_last_id" value="{$iStreamLastId}"/>
            <a class="btn btn-success btn-lg btn-block" id="stream_get_more"
               href="javascript:ls.stream.getMoreByUser({$oUserProfile->getId()})">{$aLang.stream_get_more} &darr;</a>
        {/if}
    {else}
        {$aLang.stream_no_events}
    {/if}

{/block}
