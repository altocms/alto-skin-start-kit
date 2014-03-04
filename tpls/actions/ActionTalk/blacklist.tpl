{extends file="_index.tpl"}

{block name="layout_content"}

    {include file='menus/menu.talk.tpl'}
    <section class="panel panel-default block block-type-blacklist">
        <div class="panel-body">

            <header class="block-header">
                <h3>{$aLang.talk_blacklist_title}</h3>
            </header>

            <div class="block-content">
                <form onsubmit="return ls.talk.addToBlackList();">
                    <div class="form-group">
                        <label for="talk_blacklist_add">{$aLang.talk_balcklist_add_label}</label>
                        <input type="text" id="talk_blacklist_add" name="add"
                               class="form-control autocomplete-users-sep"/>
                    </div>
                </form>

                <div id="black_list_block">
                    {if $aUsersBlacklist}
                        <ul class="list-unstyled" id="black_list">
                            {foreach $aUsersBlacklist as $oUser}
                                <li id="blacklist_item_{$oUser->getId()}_area"><a href="{$oUser->getProfileUrl()}"
                                                                                  class="user">{$oUser->getDisplayName()}</a>
                                    - <a href="#" id="blacklist_item_{$oUser->getId()}"
                                         class="delete">{$aLang.blog_delete}</a></li>
                            {/foreach}
                        </ul>
                    {/if}
                </div>
            </div>

        </div>
    </section>
{/block}
