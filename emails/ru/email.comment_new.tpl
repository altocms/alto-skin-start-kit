Пользователь <a href="{$oUserComment->getProfileUrl()}">{$oUserComment->getDisplayName()}</a>
оставил новый комментарий к топику <b>«{$oTopic->getTitle()|escape:'html'}»</b>,
прочитать его можно перейдя по <a href="{if Config::Get('module.comment.nested_per_page')}{router page='comments'}{else}{$oTopic->getUrl()}#comment{/if}{$oComment->getId()}">этой ссылке</a><br>
{if Config::Get('sys.mail.include_comment')}
	Текст сообщения: <i>{$oComment->getText()}</i>
{/if}

{if $sSubscribeKey}
	<br><br>
	<a href="{router page='subscribe'}unsubscribe/{$sSubscribeKey}/">Отписаться от новых комментариев к этому топику</a>
{/if}

<br><br>
С уважением, администрация сайта <a href="{Config::Get('path.root.url')}">{Config::Get('view.name')}</a>