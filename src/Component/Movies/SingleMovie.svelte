<script>
    export let movie;
</script>

<div class="card">
    <h3>{movie.name}</h3>
    <ul>
        {#each Object.entries(movie) as [key,val] }
            {#if key !== "_id" && key !== "name"}
                
                <li>
                    <span>{key} : </span>
                    <span>{val}</span>
                </li>
            {/if}
        {/each}
    </ul>
</div>

<style type="text/scss">
    .card {
        border: 1px solid rgba($color: #fff, $alpha: .5);
        border-radius: .5rem;
        box-shadow: 0px 0px 2px 4px rgba(196, 180, 121, 0.25);
        background-color:rgba(65, 37, 24, 0.15);
        padding:1rem;
        margin-bottom: 2rem;
        h3{
            margin:0;
        }
        ul{
            li{
                text-align: left;
                span{
                    &:first-child{
                        text-transform: capitalize;
                    }
                }
            }
        }
    }

</style>