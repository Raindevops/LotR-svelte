<script>
    import {onMount} from 'svelte';
    import ParseString from '../../Helpers/ParseString';

    export let book;
    let chapters = [];
    let chaps = [];

    onMount(async function(){

        if (localStorage.getItem(`bookID-${book._id}`)) {
            chapters = JSON.parse(localStorage.getItem(`bookID-${book._id}`))
        }

        const req = await fetch(`${__lotr.env.API_URL}/book/${book._id}/chapter`)
        .then(resp => resp.json())
        .then(data=> {
            chapters = data.docs
            localStorage.setItem(`bookID-${book._id}`, JSON.stringify(chapters))
        });

        chaps = chapters.map(chap=> {
            return chap.chapterName = ParseString.removeUselessSpace(chap.chapterName)
        });

    });
</script>
<div class="book">
    <div class="title">
        <h3>{book.name}</h3>
    </div>
    {#if chapters != undefined}
    <div class="content">
        {#await chapters}
                <p>loading</p>
        {:then _}
            <table width="100%">
                <tr>
                    <td align="left">
                        {#each chaps as chap, i}
                            {#if i <= Math.ceil(chaps.length/2)}
                                <p>{chap}</p>
                            {/if}
                        {/each}   
                    </td>
                    <td align="right">
                        {#each chaps as chap, i}
                            {#if i >= Math.ceil(chaps.length/2)}
                                <p>{chap}</p>
                            {/if}
                        {/each}  
                    </td>
                </tr>
            </table>
        {/await}
        </div>
    {/if}
</div>
<style type="text/scss">
    .content{
        text-align: left;
        max-width: 640px;
        margin: 0 auto;
        table{
            td{
                vertical-align: top;
            }
        }
    }
</style>