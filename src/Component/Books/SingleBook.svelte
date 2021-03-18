<script>
    import {onMount} from 'svelte';
    import ParseString from '../../Helpers/ParseString';

    export let book;
    let chapters = [];
    let chaps = [];

    onMount(async function(){

        if (localStorage.getItem(`bookID-${book._id}`)) {
            chapters = JSON.parse(localStorage.getItem(`bookID-${book._id}`));
            chaps = chapters.map(chap=> {
                return chap.chapterName = ParseString.removeUselessSpace(chap.chapterName)
            });
            return;
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
        <h2>{book.name}</h2>
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
                                <p class="list-item left">{chap}</p>
                            {/if}
                        {/each}   
                    </td>
                    <td align="right">
                        {#each chaps as chap, i}
                            {#if i >= Math.ceil(chaps.length/2)}
                                <p class="list-item right">{chap}</p>
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
    .book{
        display: flex;
        flex-direction: column;
        justify-content: center;
        height: 100%;
        min-height: fit-content;
        h2{
            margin:0;
        }
    }
    .content{
        text-align: left;
        max-width: 768px;
        margin: 0 auto;
        table{
            td{
                vertical-align: top;
            }
        }
    }
</style>