<script>
    export let character;
</script>

<div class="character">
    <h3><a href={character.wikiUrl}>{character.name}</a></h3>
    <ul>
        {#each Object.entries(character) as [key, val] }
            {#if val && key !== "_id" && key !== "wikiUrl" && key !=="name"}
                <li>
                    <span class="key">{key} :</span>  
                    <span class="val">{val}</span>
                </li>
            {/if}
        {/each}
    </ul>
</div>

<style type="text/scss">
$gold : #C4B479;
.character{
    margin-bottom: 2rem;
    h3{
        margin: 0;
        a{
            color: $gold;
        }
    }
    ul{
        list-style: none;
        margin-left: 0;
        li{
            .key{
                text-transform: capitalize;
            }
        }
    }
}
</style>