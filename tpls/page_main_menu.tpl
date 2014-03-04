{foreach $aPagesMain as $oPage}
	<li {if $sAction=='page' and $sEvent==$oPage->getUrl()}class="active"{/if}><a href="{router page='page'}{$oPage->getUrlFull()}/" >{$oPage->getTitle()}</a><i></i></li>
{/foreach}	