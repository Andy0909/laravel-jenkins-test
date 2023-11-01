<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Stock;

class modifyStock extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:modify-stock';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $stock = Stock::all();
    }
}
