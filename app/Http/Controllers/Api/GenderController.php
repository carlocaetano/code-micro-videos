<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Genre;
use Illuminate\Http\Request;

class GenderController extends Controller
{
    private $rules = [
        'name' => 'required|max:255',
        'is_active' => 'boolean'
    ];

    public function index()
    {
        return Genre::all();
    }

    public function store(Request $request)
    {
        $this->validate($request, $this->rules);
        $gender = Genre::create($request->all());
        $gender->refresh();
        return $gender;
    }

    public function show(Genre $gender)
    {
        return $gender;
    }

    public function update(Request $request, Genre $gender)
    {
        $this->validate($request, $this->rules);
        $gender->update($request->all());
        return $gender;
    }

    public function destroy(Genre $gender)
    {
        $gender->delete();
        return response()->noContent(); //204 - No Content
    }
}
