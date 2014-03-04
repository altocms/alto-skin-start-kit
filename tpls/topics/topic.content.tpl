{if E::Topic_IsAllowTopicType($oTopic->getType())}
    {$sTopicTemplateName=$oTopic->getTopicTypeTemplate('list')}
    {include file="topics/$sTopicTemplateName" bTopicList=true}
{/if}
