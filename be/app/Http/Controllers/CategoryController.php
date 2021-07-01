<?php 

namespace App\Http\Controllers;

use Exception;
use Ramsey\Uuid\Uuid;
use App\Models\Category;
use App\Models\Province;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CategoryController extends Controller 
{

  public function index()
  {
    $data = Category::all();
    return response()->json([
      'success'   => true,
      'message'   => 'List of Categories',
      'data'      => $data
    ],200);
  }

  public function store(Request $request)
  {
    $validation = Validator::make($request->all(),[
      'name'        => 'required|unique:blog_categories|max:255',
      'slug'        => 'required|unique:blog_categories|max:255',
      'description' => 'nullable|max:255'
    ]);

    if($validation->fails())
    {
      return response()->json($validation->errors(),400);
    }

    $id = Uuid::uuid6();
    $data = [
      'id'          => $id,
      'name'        => $request->name,
      'slug'        => $request->slug,
      'description' => $request->description
    ];

    Category::create($data);

    return response()->json([
      'success'   => true,
      'message'   => 'Created Successfully',
      'data'      => $data
    ],201);
  }

  public function show(Category $category)
  {
    if($category){
      return response()->json([
        'success'   => true,
        'message'   => 'Show Data',
        'data'      => $category
      ],200);  
    }

    return response()->json([
      'success'     => false,
      'message'     => 'Not Found',
      'data'        => null
    ],404);
  }

  public function update(Request $request, Category $category)
  {
    $validation = Validator::make($request->all(),[
      'name'        => 'required|max:255|unique:blog_categories,name,'.$category->id,
      'slug'        => 'required|max:255|unique:blog_categories,slug,'.$category->id,
      'description' => 'nullable|max:255'
    ]);

    if($validation->fails())
    {
      return response()->json($validation->errors(),400);
    }
    if($category){
      $category->update(
        [
          'name'        => $request->name,
          'slug'        => $request->slug,
          'description' => $request->description
        ]
      );
  
      return response()->json([
        'success' => true,
        'message' => 'Updated Successfully',
        'data'    => $category
      ],200);  
    }

    return response()->json([
      'success'   => false,
      'message'   => 'Data Not Found',
      'data'      => null
    ],404);
  }

  public function destroy(Category $category)
  {
    if($category)
    {
      $category->delete();
      return response()->json([
        'success'  => true,
        'message'  => 'Deleted Successfully',
        'data'     => null
      ],200);    
    }

    return response()->json([
      'success'  => false,
      'message'  => 'Data Not Found',
      'data'     => null
    ],404);
  }
}

?>